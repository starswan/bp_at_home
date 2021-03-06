class FeedbacksController < InheritedResources::Base
  before_filter :find_patient, only: [:new, :create]
  # POST /patients/1/feedback
  def create
    @feedback = @patient.feedbacks.new(feedback_params)

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to(@patient, notice: 'Thankyou for your feedback.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

private
  def feedback_params
    params.require(:feedback).permit(:text)
  end

  def find_patient
    @patient = Patient.find params[:patient_id]
  end

end
