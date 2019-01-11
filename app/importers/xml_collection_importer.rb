class XmlCollectionImporter

  def initialize(file)
    @file = file
    @user = ::User.batch_user
  end

  require 'nokogiri'
  require 'open-uri'

  def default_collection_type
    Hyrax::CollectionType.find_or_create_default_collection_type
  end

  def import
      # Fetch and parse HTML document
      #doc = Nokogiri::XML(open("spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml"))
      doc = Nokogiri::XML(open(@file))
      puts "### Search for nodes by xpath"
      doc.xpath("//xmlns:ROW").each do |link|
        coll = Collection.new
        # todo : this gid wont be right for production
        coll.collection_type_gid = default_collection_type.gid

        # "gid://tcd-hyrax-app3/hyrax-collectiontype/2"

        # todo :
        coll.depositor = "test@example.com"
        # byebug
        coll.description = ["An Abstract"]
        #coll.collection_type_gid =

        # byebug
        # title -> Title
        link.xpath("xmlns:Title").each do |aTitle|
          if !aTitle.content.blank?
            coll.title = [aTitle.content]
          end
        end

        # creator -> AttributedArtist
        link.xpath("xmlns:AttributedArtist").each do |anArtist|
          if !anArtist.content.blank?
            anArtist.xpath("xmlns:DATA").each do |individual|
                coll.creator.push(individual.content)
            end
          end
        end

        # keyword -> SubjectTMG
        link.xpath("xmlns:SubjectTMG").each do |subjects|
          if !subjects.content.blank?
            subjects.xpath("xmlns:DATA").each do |aSubject|
              coll.keyword.push(aSubject.content)
            end
          end
        end
        # byebug
        coll.save
        # byebug
      end
  end
end
