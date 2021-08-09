class TagsTasks < ApplicationRecord
  belongs_to :tag, class_name: "tag", foreign_key: "tag_id"
  belongs_to :task, class_name: "task", foreign_key: "task_id"
end