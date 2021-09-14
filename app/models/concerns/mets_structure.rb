module MetsStructure
  def structure
    structure_type('logical')
  end

  def structure_for_volume(volume_id)
    volume = volume_nodes.find { |vol| vol.attribute("ID").value == volume_id }
    { nodes: structure_for_nodeset(volume.element_children) }
  end

  def file_label(file_id)
    struct = structure_map('logical')
    node = struct.xpath(".//mets:fptr[@FILEID='#{file_id}']").first if struct
    (label_from_hierarchy(node.parent) if node) ||
      label_from_related_objects(file_id)
  end

  private

    def structure_map(type)
      @mets.xpath("/mets:mets/mets:structMap[@TYPE='#{type}']").first
    end

    def structure_type(type)
      return nil unless structure_map(type)
      top = structure_map(type).xpath("mets:div/mets:div")
      return nil if top.blank?
      { label: 'Logical', nodes: structure_for_nodeset(top) }
    end

    def structure_for_nodeset(nodeset)
      nodes = []
      nodeset.each do |node|
        nodes << structure_recurse(node)
      end
      nodes
    end

    def structure_recurse(node)
      children = node.element_children
      return single_file_object(node) if children.blank? && node.name == 'fptr'
      return single_file_object(children.first) if !section(node) &&
                                                   single_file(children)

      child_nodes = []
      if single_file(children)
        child_nodes = [single_file_object(children.first)]
      else
        children.each do |child|
          child_nodes << structure_recurse(child)
        end
      end
      node_id = node["FILEID"]
      node_id = node['ID'] if node_id.blank?
      node_id = "#{node["TYPE"]} #{node['ORDER']}" if node_id.blank? &&
                                                      node['TYPE'].present?
      { label: node_id, nodes: child_nodes }
    end

    def section(node)
      node.attributes["TYPE"].try(:value) == "archivalitem"
    end

    def single_file(nodeset)
      nodeset.length == 1 && nodeset.first.name == 'fptr'
    end

    def single_file_object(node)
      id = node['FILEID']
      label = label_from_hierarchy(node.parent) ||
              label_from_related_objects(id)
      label = nil if label.blank?
      { label: label, proxy: id }
    end

    def label_from_hierarchy(node)
      return nil unless node['FILEID']
      current = node
      label = current['FILEID']
      while current.parent['FILEID'] && in_scope(current.parent)
        label = "#{current.parent['FILEID']}. #{label}"
        current = current.parent
      end
      label
    end

    def in_scope(node)
      if multi_volume?
        node.parent.parent.name == 'div'
      else
        node.parent.name == 'div'
      end
    end

    def label_from_related_objects(id)
      @mets.xpath("/mets:mets/mets:structMap[@TYPE='RelatedObjects']" \
                  "//mets:div[mets:fptr/@FILEID='#{id}']/@FILEID").to_s
    end
end
