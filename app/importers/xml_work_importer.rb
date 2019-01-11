class XmlWorkImporter

  def initialize(file)
    @file = file
    #@user = ::User.batch_user
  end

  require 'nokogiri'
  require 'open-uri'

  def import
      # Fetch and parse HTML document
      #doc = Nokogiri::XML(open("spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml"))
      doc = Nokogiri::XML(open(@file))
      puts "### Search for nodes by xpath"
      doc.xpath("//xmlns:ROW").each do |link|
        work = Work.new
        work.depositor = "cataloger@tcd.ie"
        #fs = FileSet.new
        #fs.title = ["testing title for fileset"]
        #fs.save
        #work.members << fs

        # byebug
        # title -> Title
        link.xpath("xmlns:Title").each do |aTitle|
          if !aTitle.content.blank?
            work.title = [aTitle.content]
          end
        end

        # creator -> AttributedArtist
        link.xpath("xmlns:AttributedArtist").each do |anArtist|
          if !anArtist.content.blank?
            anArtist.xpath("xmlns:DATA").each do |individual|
                work.creator.push(individual.content)
            end
          end
        end

        # keyword -> SubjectTMG
        link.xpath("xmlns:SubjectTMG").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              work.keyword.push(aSubject.content)
            end
          end
        end

        # rights_statement -> CopyrightStatus
        link.xpath("xmlns:CopyrightStatus").each do |statuses|
          if !statuses.content.blank?
            statuses.xpath("xmlns:DATA").each do |aStatus|
              work.rights_statement.push(aStatus.content)
            end
          end
        end

        # abstract
        link.xpath("xmlns:Abstract").each do |abstract|
          if !abstract.content.blank?
            work.description = [abstract.content]
          end
        end

        # publisher
        link.xpath("xmlns:Publisher").each do |publisher|
          if !publisher.content.blank?
            work.publisher = [publisher.content]
          end
        end

        # date created
        link.xpath("xmlns:DateCalculation").each do |calcDates|
          if !calcDates.content.blank?
            calcDates.xpath("xmlns:DATA").each do |aCalcDate|
              work.date_created.push(aCalcDate.content)
            end
          end
        end

        # subject
        link.xpath("xmlns:SubjectTMG").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              work.subject.push(aSubject.content)
            end
          end
        end

        # language
        link.xpath("xmlns:Language").each do |languages|
          if !languages.content.blank?
            languages.xpath("xmlns:DATA").each do |aLanguage|
              work.language.push(aLanguage.content)
            end
          end
        end

        # identifier  -> CatNo
        link.xpath("xmlns:CatNo").each do |catno|
          if !catno.content.blank?
            work.identifier = [catno.content]
          end
        end

        # resource_type
        link.xpath("xmlns:Type").each do |aType|
          if !aType.content.blank?
            work.resource_type = [aType.content]
          end
        end

        # genre -> TypeOfWork
        link.xpath("xmlns:TypeOfWork").each do |aTypeOfWork|
          if !aTypeOfWork.content.blank?
            work.genre = [aTypeOfWork.content]
          end
        end

        # bibliography
        link.xpath("xmlns:Bibliography").each do |aBibliography|
          if !aBibliography.content.blank?
            work.bibliography = [aBibliography.content]
          end
        end

        # dris_page_no
        link.xpath("xmlns:DrisPageNo").each do |aDrisPageNo|
          if !aDrisPageNo.content.blank?
            work.dris_page_no = [aDrisPageNo.content]
          end
        end

        # dris_document_no
        link.xpath("xmlns:DrisDocumentNo").each do |aDrisDocumentNo|
          if !aDrisDocumentNo.content.blank?
            work.dris_document_no = [aDrisDocumentNo.content]
          end
        end

        # dris_unique
        link.xpath("xmlns:DrisUnique").each do |aDrisUnique|
          if !aDrisUnique.content.blank?
            work.dris_unique = [aDrisUnique.content]
          end
        end

        # format_duration
        link.xpath("xmlns:FormatDur").each do |aFormatDuration|
          if !aFormatDuration.content.blank?
            work.format_duration = [aFormatDuration.content]
          end
        end

        # format_resolution
        link.xpath("xmlns:FormatResolution").each do |aFormatResolution|
          if !aFormatResolution.content.blank?
            work.format_resolution = [aFormatResolution.content]
          end
        end

        # copyright_holder
        link.xpath("xmlns:CopyrightHolder").each do |copyrightHolders|
          if !copyrightHolders.content.blank?
            copyrightHolders.xpath("xmlns:DATA").each do |aCopyrightHolder|
              work.copyright_holder.push(aCopyrightHolder.content)
            end
          end
        end

        # copyright_note
        link.xpath("xmlns:CopyrightNotes").each do |copyrightNotes|
          if !copyrightNotes.content.blank?
            copyrightNotes.xpath("xmlns:DATA").each do |aCopyrightNote|
              work.copyright_note.push(aCopyrightNote.content)
            end
          end
        end

        # digital_root_number -> CatNo
        link.xpath("xmlns:CatNo").each do |aDigitalRootNumber|
          if !aDigitalRootNumber.content.blank?
            work.digital_root_number = [aDigitalRootNumber.content]
          end
        end

        # digital_object_identifier -> DRISPhotoID
        link.xpath("xmlns:DRISPhotoID").each do |aDigitalObjectId|
          if !aDigitalObjectId.content.blank?
            work.digital_object_identifier = [aDigitalObjectId.content]
          end
        end


        # language_code -> LanguageTermCode
        link.xpath("xmlns:LanguageTermCode").each do |languageCodes|
          if !languageCodes.content.blank?
            languageCodes.xpath("xmlns:DATA").each do |aLanguageCode|
              work.language_code.push(aLanguageCode.content)
            end
          end
        end

        # location_type -> LocationType
        link.xpath("xmlns:LocationType").each do |locationTypes|
          if !locationTypes.content.blank?
            locationTypes.xpath("xmlns:DATA").each do |aLocationType|
              work.location_type.push(aLocationType.content)
            end
          end
        end

        # shelf_locator -> Citation
        link.xpath("xmlns:Citation").each do |aShelfLocation|
          if !aShelfLocation.content.blank?
            work.shelf_locator = [aShelfLocation.content]
          end
        end

        # role_code -> AttributedArtistRoleCode
        link.xpath("xmlns:AttributedArtistRoleCode").each do |roleCodes|
          if !roleCodes.content.blank?
            roleCodes.xpath("xmlns:DATA").each do |aRoleCode|
              work.role_code.push(aRoleCode.content)
            end
          end
        end

        # role -> AttributedArtistRole
        link.xpath("xmlns:AttributedArtistRole").each do |roles|
          if !roles.content.blank?
            roles.xpath("xmlns:DATA").each do |aRole|
              work.role.push(aRole.content)
            end
          end
        end

        # sponsor -> Sponsor
        link.xpath("xmlns:Sponsor").each do |aSponsor|
          if !aSponsor.content.blank?
            work.sponsor.push(aSponsor.content)
          end
        end

        # conservation_history -> Introduction
        link.xpath("xmlns:Introduction").each do |aConsHist|
          if !aConsHist.content.blank?
            work.conservation_history.push(aConsHist.content)
          end
        end

        # publisher_location -> PublisherCity; PublisherCountry
        link.xpath("xmlns:PublisherCity").each do |aPublisherLoc|
          if !aPublisherLoc.content.blank?
            work.publisher_location.push(aPublisherLoc.content)
          end
        end
        link.xpath("xmlns:PublisherCountry").each do |aPublisherLoc|
          if !aPublisherLoc.content.blank?
            work.publisher_location.push(aPublisherLoc.content)
          end
        end

        # page_number -> PageNo; PageNoB
        link.xpath("xmlns:PageNo").each do |aPageNo|
          if !aPageNo.content.blank?
            work.page_number.push(aPageNo.content)
          end
        end
        link.xpath("xmlns:PageNoB").each do |aPageNo|
          if !aPageNo.content.blank?
            work.page_number.push(aPageNo.content)
          end
        end

        # page_type -> PageType; PageTypeB
        link.xpath("xmlns:PageType").each do |aPageType|
          if !aPageType.content.blank?
            work.page_type.push(aPageType.content)
          end
        end
        link.xpath("xmlns:PageTypeB").each do |aPageType|
          if !aPageType.content.blank?
            work.page_type.push(aPageType.content)
          end
        end

        # physical_extent -> FormatW
        link.xpath("xmlns:FormatW").each do |aPhysicalExtent|
          if !aPhysicalExtent.content.blank?
            work.physical_extent.push(aPhysicalExtent.content)
          end
        end

        # support
        link.xpath("xmlns:Support").each do |supports|
          if !supports.content.blank?
            supports.xpath("xmlns:DATA").each do |aSupport|
              work.support.push(aSupport.content)
            end
          end
        end

        # medium
        link.xpath("xmlns:Medium").each do |mediums|
          if !mediums.content.blank?
            mediums.xpath("xmlns:DATA").each do |aMedium|
              work.medium.push(aMedium.content)
            end
          end
        end

        # type_of_work
        link.xpath("xmlns:TypeOfWork").each do |aType|
          if !aType.content.blank?
            work.type_of_work.push(aType.content)
          end
        end

        # related_item_type
        link.xpath("xmlns:RelatedItemType").each do |relatedItemTypes|
          if !relatedItemTypes.content.blank?
            relatedItemTypes.xpath("xmlns:DATA").each do |aRelatedItemType|
              work.related_item_type.push(aRelatedItemType.content)
            end
          end
        end

        # related_item_identifier
        link.xpath("xmlns:RelatedItemIdentifier").each do |relatedItemIdentifier|
          if !relatedItemIdentifier.content.blank?
            relatedItemIdentifier.xpath("xmlns:DATA").each do |aRelatedItemIdentifier|
              work.related_item_identifier.push(aRelatedItemIdentifier.content)
            end
          end
        end

        # related_item_title
        link.xpath("xmlns:RelatedItemTitle").each do |relatedItemTitle|
          if !relatedItemTitle.content.blank?
            relatedItemTitle.xpath("xmlns:DATA").each do |aRelatedItemTitle|
              work.related_item_title.push(aRelatedItemTitle.content)
            end
          end
        end

        # subject_lcsh -> SubjectLCSH
        link.xpath("xmlns:SubjectLCSH").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              work.subject_lcsh.push(aSubject.content)
            end
          end
        end

        # subject_local -> OpenKeyword
        link.xpath("xmlns:OpenKeyword").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              work.subject_local.push(aSubject.content)
            end
          end
        end

        # subject_name -> LCSubjectNames
        link.xpath("xmlns:LCSubjectNames").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              work.subject_name.push(aSubject.content)
            end
          end
        end

        # alternative_title -> OtherTitle
        link.xpath("xmlns:OtherTitle").each do |titles|
          if !titles.content.blank?
            titles.xpath("xmlns:DATA").each do |aTitle|
              work.alternative_title.push(aTitle.content)
            end
          end
        end

        # series_title -> SeriesReportNo
        link.xpath("xmlns:SeriesReportNo").each do |titles|
          if !titles.content.blank?
            titles.xpath("xmlns:DATA").each do |aTitle|
              work.series_title.push(aTitle.content)
            end
          end
        end

        # collection_title -> TitleLargerEntity
        link.xpath("xmlns:TitleLargerEntity").each do |aTitle|
          if !aTitle.content.blank?
            work.collection_title.push(aTitle.content)
          end
        end

        # virtual_collection_title -> TitleLargerEntity2
        link.xpath("xmlns:TitleLargerEntity2").each do |aTitle|
          if !aTitle.content.blank?
            work.virtual_collection_title.push(aTitle.content)
          end
        end

        # provenance
        link.xpath("xmlns:Provenance").each do |aProvenance|
          if !aProvenance.content.blank?
            work.provenance.push(aProvenance.content)
          end
        end

        # visibility_flag
        link.xpath("xmlns:Visibility").each do |visibilityFlag|
          if !visibilityFlag.content.blank?
            work.visibility_flag.push(visibilityFlag.content)
          end
        end

        # europeana
        link.xpath("xmlns:Europeana").each do |europeanaFlag|
          if !europeanaFlag.content.blank?
            work.europeana.push(europeanaFlag.content)
          end
        end

        # solr_flag -> Image
        link.xpath("xmlns:Image").each do |imageFlag|
          if !imageFlag.content.blank?
            work.solr_flag.push(imageFlag.content)
          end
        end

        # culture -> Culture
        link.xpath("xmlns:Culture").each do |cultures|
          if !cultures.content.blank?
            cultures.xpath("xmlns:DATA").each do |aCulture|
              work.culture.push(aCulture.content)
            end
          end
        end

        # county -> CALM
        link.xpath("xmlns:CALM").each do |calmRef|
          if !calmRef.content.blank?
            work.county.push(calmRef.content)
          end
        end

        # project_number
        link.xpath("xmlns:ProjectNo").each do |projNo|
          if !projNo.content.blank?
            work.project_number.push(projNo.content)
          end
        end

        # order_no -> LCN
        link.xpath("xmlns:LCN").each do |orderNo|
          if !orderNo.content.blank?
            work.order_no.push(orderNo.content)
          end
        end

        # total_records
        link.xpath("xmlns:PageTotal").each do |totalRecs|
          if !totalRecs.content.blank?
            work.total_records.push(totalRecs.content)
          end
        end

        work.save
      end
  end
end
