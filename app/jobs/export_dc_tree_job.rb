class ExportDcTreeJob < ApplicationJob
  queue_as :export

  def perform(objectId)

    prep_for_export_job(objectId)

  end

  private

  def prep_for_export_job(objectId)

    obj = ActiveFedora::Base.find(objectId, cast: true)
    #byebug
    if obj.work?
      work_array = [obj]
      ExportDublinCoreJob.perform_later(work_array)

      if obj.members.size > 0
      # need to go down through the tree recursively
      # need to manage the order of the children too. So use ordered_members
      #byebug
        children = obj.ordered_members.to_ary
        children.each do | child |
          prep_for_export_job(child.id)
        end
      end

    end
  end


end
