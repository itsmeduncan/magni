require 'rails_helper'

describe ::Magni::V1::Entry, type: :model do

  context '.initialize' do
    it 'has an id' do
      expect(described_class.new.id).to_not be_blank
    end

    it 'has a type' do
      expect(described_class.new.type).to eq('magni-v1-entry')
    end

    it 'has raw data' do
      expect(described_class.new({bananas: 'foo'}).raw_data).to eq({bananas: 'foo'})
    end

    it 'has a created_at timestamp' do
      expect(described_class.new.created_at).to_not be_blank
    end
  end

  context '#to_json' do
    it 'raises an exception' do
      expect(described_class.new.to_json).to_not be_blank
    end
  end

  context '#content_type' do
    it 'defaults to JSON' do
      expect(described_class.new.content_type).to eq('application/json')
    end
  end

  context 'with a subclass' do
    subject {
      Class.new(::Magni::V1::Entry) do
        attr_accessor :bar

        def self.name
          'Foo'
        end

        def to_json
          "foo"
        end

        def content_type
          "bar"
        end
      end
    }

    context '#bucket_name' do
      it 'returns the bucket name' do
        expect(subject.new.bucket_name).to eq('foos')
      end
    end

    context '#bucket' do
      it 'returns the bucket' do
        expect(subject.new.bucket).to be_a(Riak::Bucket)
      end
    end

    context '#save' do
      it 'returns true' do
        stub_const("STORAGE", double("riak", {
          bucket: double("bucket", {
            get_or_new: double("robject", {
              :raw_data= => "foo",
              :content_type= => "bar",
              :to_json => "foo",
              :store => true
            })
          })
        }))

        expect { subject.new.save }.to_not raise_exception
      end
    end

    context "#find" do
      it 'returns the object' do
        stub_const("STORAGE", double("riak", {
          :[] => double("bucket", {
            :[] => 'foo'
          })
        }))

        foo = subject.new
        expect(subject.find(foo.id)).to eq('foo')
      end
    end
  end
end
