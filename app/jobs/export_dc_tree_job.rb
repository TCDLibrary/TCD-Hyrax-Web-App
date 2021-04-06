class ExportDcTreeJob < ApplicationJob
  queue_as :export

  def perform(objectId)

    prep_for_export_job(objectId)

  end

  private

  def prep_for_export_job(objectId, name_qualifier = '')

    obj = ActiveFedora::Base.find(objectId, cast: true)
    #byebug
    if obj.work?
      work_array = [obj]
      ExportDublinCoreJob.perform_later(work_array, name_qualifier)

      if obj.members.size > 0
      # need to go down through the tree recursively
      # need to manage the order of the children too. So use ordered_members
      #byebug
        children = obj.ordered_members.to_ary
        children.each_with_index do | child, i |
          human_index = '%04i' % (i + 1)
          prep_for_export_job(child.id, "#{name_qualifier}#{objectId}_#{human_index}_")
        end
      end

    end
  end


end
