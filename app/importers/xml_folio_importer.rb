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
        #folio.depositor = "cataloger@tcd.ie"

        byebug
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
        byebug

        # creator -> AttributedArtist
        link.xpath("xmlns:AttributedArtist").each do |anArtist|
          if !anArtist.content.blank?
            anArtist.xpath("xmlns:DATA").each do |individual|
                folio.creator.push(individual.content)
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

        # fs = FileSet.new
        # fs.title = ["testing title for fileset"]

        image_binary = File.open("#{imageLocation}")
        uploaded_file = Hyrax::UploadedFile.create(user: @user, file: image_binary)
        attributes_for_actor = { uploaded_files: [uploaded_file.id] }
        env = Hyrax::Actors::Environment.new(folio, ::Ability.new(@user), attributes_for_actor)
        Hyrax::CurationConcern.actor.create(env)
        image_binary.close

        # fs.save
        # folio.members << fs

        byebug

        #folio.save
      end
  end
end
