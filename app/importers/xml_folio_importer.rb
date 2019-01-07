class XmlFolioImporter

  def initialize(file)
    @file = file
    @user = ::User.batch_user
  end

  require 'nokogiri'
  require 'open-uri'

  def import
      # Fetch and parse HTML document
      #doc = Nokogiri::XML(open("spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml"))
      doc = Nokogiri::XML(open(@file))
      puts "### Search for nodes by xpath"
      doc.xpath("//xmlns:ROW").each do |link|
        folio = Folio.new
        folio.depositor = @user.email


        #byebug
        # title -> Title
        link.xpath("xmlns:Title").each do |aTitle|
          if !aTitle.content.blank?
            folio.title = [aTitle.content]
          end
        end

        # folder_number -> ProjectName
        link.xpath("xmlns:ProjectName").each do |projectName|
          if !projectName.content.blank?
            folio.folder_number = [projectName.content]
          end
        end

        # dris_document_no -> DRISPhotoID
        link.xpath("xmlns:DRISPhotoID").each do |drisPhotoId|
          if !drisPhotoId.content.blank?
            folio.dris_document_no = [drisPhotoId.content]
          end
        end

        imageFileName = folio.dris_document_no.first + "_LO.jpg"
        imageLocation = "spec/fixtures/" + imageFileName
        #byebug

        # creator -> AttributedArtist
        link.xpath("xmlns:AttributedArtist").each do |anArtist|
          if !anArtist.content.blank?
            anArtist.xpath("xmlns:DATA").each do |individual|
                folio.creator.push(individual.content)
                folio.contributor.push(individual.content)
            end
          end
        end

        # keyword -> SubjectTMG
        link.xpath("xmlns:SubjectTMG").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              folio.keyword.push(aSubject.content)
            end
          end
        end

        # rights_statement -> CopyrightStatus
        link.xpath("xmlns:CopyrightStatus").each do |statuses|
          if !statuses.content.blank?
            statuses.xpath("xmlns:DATA").each do |aStatus|
              folio.rights_statement.push(aStatus.content)
            end
          end
        end

        # abstract
        link.xpath("xmlns:Abstract").each do |abstract|
          if !abstract.content.blank?
            folio.description = [abstract.content]
          end
        end

        # license
        # TODO:

        # publisher
        link.xpath("xmlns:Publisher").each do |publisher|
          if !publisher.content.blank?
            folio.publisher = [publisher.content]
          end
        end

        # date created
        link.xpath("xmlns:DateCalculation").each do |calcDates|
          if !calcDates.content.blank?
            calcDates.xpath("xmlns:DATA").each do |aCalcDate|
              folio.date_created.push(aCalcDate.content)
            end
          end
        end

        # subject
        link.xpath("xmlns:SubjectTMG").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              folio.subject.push(aSubject.content)
            end
          end
        end

        # language
        link.xpath("xmlns:Language").each do |languages|
          if !languages.content.blank?
            languages.xpath("xmlns:DATA").each do |aLanguage|
              folio.language.push(aLanguage.content)
            end
          end
        end

        # identifier  -> CatNo
        link.xpath("xmlns:CatNo").each do |catno|
          if !catno.content.blank?
            folio.identifier = [catno.content]
          end
        end

        # location
        # TODO:

        # related_url
        # TODO:

        # source
        # TO DO:

        # resource_type
        link.xpath("xmlns:Type").each do |aType|
          if !aType.content.blank?
            folio.resource_type = [aType.content]
          end
        end

        # genre -> TypeOfWork
        link.xpath("xmlns:TypeOfWork").each do |aTypeOfWork|
          if !aTypeOfWork.content.blank?
            folio.genre = [aTypeOfWork.content]
          end
        end

        # bibliography
        link.xpath("xmlns:Bibliography").each do |aBibliography|
          if !aBibliography.content.blank?
            folio.bibliography = [aBibliography.content]
          end
        end

        # dris_page_no
        link.xpath("xmlns:DrisPageNo").each do |aDrisPageNo|
          if !aDrisPageNo.content.blank?
            folio.dris_page_no = [aDrisPageNo.content]
          end
        end

        # dris_document_no
        link.xpath("xmlns:DrisDocumentNo").each do |aDrisDocumentNo|
          if !aDrisDocumentNo.content.blank?
            folio.dris_document_no = [aDrisDocumentNo.content]
          end
        end

        # dris_unique
        link.xpath("xmlns:DrisUnique").each do |aDrisUnique|
          if !aDrisUnique.content.blank?
            folio.dris_unique = [aDrisUnique.content]
          end
        end

        # format_duration
        link.xpath("xmlns:FormatDur").each do |aFormatDuration|
          if !aFormatDuration.content.blank?
            folio.format_duration = [aFormatDuration.content]
          end
        end

        # format_resolution
        link.xpath("xmlns:FormatResolution").each do |aFormatResolution|
          if !aFormatResolution.content.blank?
            folio.format_resolution = [aFormatResolution.content]
          end
        end

        # copyright_holder
        link.xpath("xmlns:CopyrightHolder").each do |copyrightHolders|
          if !copyrightHolders.content.blank?
            copyrightHolders.xpath("xmlns:DATA").each do |aCopyrightHolder|
              folio.copyright_holder.push(aCopyrightHolder.content)
            end
          end
        end

        # copyright_note
        link.xpath("xmlns:CopyrightNotes").each do |copyrightNotes|
          if !copyrightNotes.content.blank?
            copyrightNotes.xpath("xmlns:DATA").each do |aCopyrightNote|
              folio.copyright_note.push(aCopyrightNote.content)
            end
          end
        end

        # digital_root_number -> CatNo
        link.xpath("xmlns:CatNo").each do |aDigitalRootNumber|
          if !aDigitalRootNumber.content.blank?
            folio.digital_root_number = [aDigitalRootNumber.content]
          end
        end

        # digital_object_identifier -> DRISPhotoID
        link.xpath("xmlns:DRISPhotoID").each do |aDigitalObjectId|
          if !aDigitalObjectId.content.blank?
            folio.digital_object_identifier = [aDigitalObjectId.content]
          end
        end

        # language_code -> LanguageTermCode
        link.xpath("xmlns:LanguageTermCode").each do |languageCodes|
          if !languageCodes.content.blank?
            languageCodes.xpath("xmlns:DATA").each do |aLanguageCode|
              folio.language_code.push(aLanguageCode.content)
            end
          end
        end

        # location_type -> LocationType
        link.xpath("xmlns:LocationType").each do |locationTypes|
          if !locationTypes.content.blank?
            locationTypes.xpath("xmlns:DATA").each do |aLocationType|
              folio.location_type.push(aLocationType.content)
            end
          end
        end

        # shelf_locator -> Citation
        link.xpath("xmlns:Citation").each do |aShelfLocation|
          if !aShelfLocation.content.blank?
            folio.shelf_locator = [aShelfLocation.content]
          end
        end

        # role_code -> AttributedArtistRoleCode
        link.xpath("xmlns:AttributedArtistRoleCode").each do |roleCodes|
          if !roleCodes.content.blank?
            roleCodes.xpath("xmlns:DATA").each do |aRoleCode|
              folio.role_code.push(aRoleCode.content)
            end
          end
        end

        # role -> AttributedArtistRole
        link.xpath("xmlns:AttributedArtistRole").each do |roles|
          if !roles.content.blank?
            roles.xpath("xmlns:DATA").each do |aRole|
              folio.role.push(aRole.content)
            end
          end
        end

        # sponsor -> Sponsor
        link.xpath("xmlns:Sponsor").each do |aSponsor|
          if !aSponsor.content.blank?
            folio.sponsor.push(aSponsor.content)
          end
        end

        # conservation_history -> Introduction
        link.xpath("xmlns:Introduction").each do |aConsHist|
          if !aConsHist.content.blank?
            folio.conservation_history.push(aConsHist.content)
          end
        end

        # publisher_location -> PublisherCity; PublisherCountry
        link.xpath("xmlns:PublisherCity").each do |aPublisherLoc|
          if !aPublisherLoc.content.blank?
            folio.publisher_location.push(aPublisherLoc.content)
          end
        end
        link.xpath("xmlns:PublisherCountry").each do |aPublisherLoc|
          if !aPublisherLoc.content.blank?
            folio.publisher_location.push(aPublisherLoc.content)
          end
        end

        # page_number -> PageNo; PageNoB
        link.xpath("xmlns:PageNo").each do |aPageNo|
          if !aPageNo.content.blank?
            folio.page_number.push(aPageNo.content)
          end
        end
        link.xpath("xmlns:PageNoB").each do |aPageNo|
          if !aPageNo.content.blank?
            folio.page_number.push(aPageNo.content)
          end
        end

        # page_type -> PageType; PageTypeB
        link.xpath("xmlns:PageType").each do |aPageType|
          if !aPageType.content.blank?
            folio.page_type.push(aPageType.content)
          end
        end
        link.xpath("xmlns:PageTypeB").each do |aPageType|
          if !aPageType.content.blank?
            folio.page_type.push(aPageType.content)
          end
        end

        # physical_extent -> FormatW
        link.xpath("xmlns:FormatW").each do |aPhysicalExtent|
          if !aPhysicalExtent.content.blank?
            folio.physical_extent.push(aPhysicalExtent.content)
          end
        end

        # support
        link.xpath("xmlns:Support").each do |supports|
          if !supports.content.blank?
            supports.xpath("xmlns:DATA").each do |aSupport|
              folio.support.push(aSupport.content)
            end
          end
        end

        # medium
        link.xpath("xmlns:Medium").each do |mediums|
          if !mediums.content.blank?
            mediums.xpath("xmlns:DATA").each do |aMedium|
              folio.medium.push(aMedium.content)
            end
          end
        end

        # type_of_work
        link.xpath("xmlns:TypeOfWork").each do |aType|
          if !aType.content.blank?
            folio.type_of_work.push(aType.content)
          end
        end

        # related_item_type
        link.xpath("xmlns:RelatedItemType").each do |relatedItemTypes|
          if !relatedItemTypes.content.blank?
            relatedItemTypes.xpath("xmlns:DATA").each do |aRelatedItemType|
              folio.related_item_type.push(aRelatedItemType.content)
            end
          end
        end

        # related_item_identifier
        link.xpath("xmlns:RelatedItemIdentifier").each do |relatedItemIdentifier|
          if !relatedItemIdentifier.content.blank?
            relatedItemIdentifier.xpath("xmlns:DATA").each do |aRelatedItemIdentifier|
              folio.related_item_identifier.push(aRelatedItemIdentifier.content)
            end
          end
        end

        # related_item_title
        link.xpath("xmlns:RelatedItemTitle").each do |relatedItemTitle|
          if !relatedItemTitle.content.blank?
            relatedItemTitle.xpath("xmlns:DATA").each do |aRelatedItemTitle|
              folio.related_item_title.push(aRelatedItemTitle.content)
            end
          end
        end

        # subject_lcsh -> SubjectLCSH
        link.xpath("xmlns:SubjectLCSH").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              folio.subject_lcsh.push(aSubject.content)
            end
          end
        end

        # subject_local -> OpenKeyword
        link.xpath("xmlns:OpenKeyword").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              folio.subject_local.push(aSubject.content)
            end
          end
        end

        # subject_name -> LCSubjectNames
        link.xpath("xmlns:LCSubjectNames").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              folio.subject_name.push(aSubject.content)
            end
          end
        end

        # alternative_title -> OtherTitle
        link.xpath("xmlns:OtherTitle").each do |titles|
          if !titles.content.blank?
            titles.xpath("xmlns:DATA").each do |aTitle|
              folio.alternative_title.push(aTitle.content)
            end
          end
        end

        # series_title -> SeriesReportNo
        link.xpath("xmlns:SeriesReportNo").each do |titles|
          if !titles.content.blank?
            titles.xpath("xmlns:DATA").each do |aTitle|
              folio.series_title.push(aTitle.content)
            end
          end
        end

        # collection_title -> TitleLargerEntity
        link.xpath("xmlns:TitleLargerEntity").each do |aTitle|
          if !aTitle.content.blank?
            folio.collection_title.push(aTitle.content)
          end
        end

        # virtual_collection_title -> TitleLargerEntity2
        link.xpath("xmlns:TitleLargerEntity2").each do |aTitle|
          if !aTitle.content.blank?
            folio.virtual_collection_title.push(aTitle.content)
          end
        end

        # provenance
        link.xpath("xmlns:Provenance").each do |aProvenance|
          if !aProvenance.content.blank?
            folio.provenance.push(aProvenance.content)
          end
        end

        # visibility_flag
        link.xpath("xmlns:Visibility").each do |visibilityFlag|
          if !visibilityFlag.content.blank?
            folio.visibility_flag.push(visibilityFlag.content)
          end
        end

        # europeana
        link.xpath("xmlns:Europeana").each do |europeanaFlag|
          if !europeanaFlag.content.blank?
            folio.europeana.push(europeanaFlag.content)
          end
        end

        # solr_flag -> Image
        link.xpath("xmlns:Image").each do |imageFlag|
          if !imageFlag.content.blank?
            folio.solr_flag.push(imageFlag.content)
          end
        end

        # culture -> Culture
        link.xpath("xmlns:Culture").each do |cultures|
          if !cultures.content.blank?
            cultures.xpath("xmlns:DATA").each do |aCulture|
              folio.culture.push(aCulture.content)
            end
          end
        end

        # county -> CALM
        link.xpath("xmlns:CALM").each do |calmRef|
          if !calmRef.content.blank?
            folio.county.push(calmRef.content)
          end
        end

        # project_number
        link.xpath("xmlns:ProjectNo").each do |projNo|
          if !projNo.content.blank?
            folio.project_number.push(projNo.content)
          end
        end

        # order_no -> LCN
        link.xpath("xmlns:LCN").each do |orderNo|
          if !orderNo.content.blank?
            folio.order_no.push(orderNo.content)
          end
        end

        # total_records
        link.xpath("xmlns:PageTotal").each do |totalRecs|
          if !totalRecs.content.blank?
            folio.total_records.push(totalRecs.content)
          end
        end



        folio.save

        #byebug
        #fs = FileSet.new
        #fs.id = 'file-1'
        #fs.title = ["testing title for fileset"]
        # fs.save
        #folio.save
        #myImg = folio.files.build
        #myImg.content = File.open("#{imageLocation}")
        #byebug
        #myImg.save
        #folio.save
        #fs.save

        #folio.edit_groups = ["test_group"]
        #folio.access_control.permissions.to_a

        #byebug
        #folio_binary = File.open("#{imageLocation}")
        #uploaded_file = Hyrax::UploadedFile.create(user: @user, file: folio_binary)
        #newfile = Hydra::PCDM::File.new(uploaded_file)
        #fs.files << uploaded_file
        #fs.save
        #folio.members << fs
        #folio.save


        #newfile = Hydra::PCDM::File.new(name:"file name")
        #new_file = FileSet.new
        #byebug
        # folio.attach_file(new_file, "spec/fixtures/")
        #byebug


        #byebug
        #uploaded_file = Hyrax::UploadedFile.create(user: @user, file: folio_binary)
        #attributes_for_actor = { uploaded_files: [uploaded_file.id] }
        #env = Hyrax::Actors::Environment.new(folio, ::Ability.new(@user), attributes_for_actor)
        #begin
        #  show Hydra::AccessControls::Permissions::GROUP_AGENT_URL_PREFIX
        #rescue
        #  Hydra::AccessControls::Permissions::GROUP_AGENT_URL_PREFIX('http://projecthydra.org/ns/auth/group'.freeze)
        #end
          # code that raises exception
        #  Hyrax::CurationConcern.actor.create(env)
        #rescue StandardError => e
        #  puts e.backtrace
        #end


        #folio_binary.close

        # fs.save
        # folio.members << fs

        #byebug

        #folio.save
      end
  end
end
