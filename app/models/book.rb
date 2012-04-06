class Book < ActiveRecord::Base
    attr_accessible :title, :author, :pages, :status, :started_at, :finished_at, :visible

    belongs_to :user

    validates :title, :presence => true,
              :length => { :maximum => 200 }
    validates :author, :presence => true,
              :length => { :maximum => 50 }

    default_scope :order => 'books.finished_at DESC'

    def Book.status
        books = ["Finished", "Reading", "On Hold", "Queued"]
    end
end
