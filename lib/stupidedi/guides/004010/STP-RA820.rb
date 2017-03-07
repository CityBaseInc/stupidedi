module Stupidedi
  module Guides
    module FortyTen
      module STP

        b = GuideBuilder
        d = Schema
        r = SegmentReqs
        e = ElementReqs
        s = Versions::FunctionalGroups::FortyTen::SegmentDefs
        t = Versions::FunctionalGroups::FortyTen::TransactionSetDefs

        RA820 = b.build(t::STP820,
          d::TableDef.header("Table 1 - Header",
            b::Segment(10, s::ST, "Transaction Set Header",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Transaction Set Identifier Code", b::Values("820")),
              b::Element(e::Required,    "Transaction Set Control Number")
              ),
            b::Segment(20, s::BPR, "Financial Information",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Transaction Handling Code", b::Values("C")),
              b::Element(e::Required,    "Monetary Amount", b::MaxLength(10)),
              b::Element(e::Required,    "Credit or Debit Flag Code", b::Values("C")),
              b::Element(e::Required,    "Payment Method Code", b::Values("ACH")),
              b::Element(e::Required,    "Payment Format Code", b::Values("CTX")),
              b::Element(e::NotUsed,     "(ODFI) ID Number Qualifier", b::Values("01")),
              b::Element(e::NotUsed,     "(ODFI) Identification Number"),
              b::Element(e::NotUsed,     "Account Number Qualifier", b::Values("DA")),
              b::Element(e::NotUsed,     "Account Number"),
              b::Element(e::Situational, "Originating Company Identifier"),
              b::Element(e::NotUsed,     "Originating Company Supplemental Code"),
              b::Element(e::Required,    "(RDFI) ID Number Qualifier", b::Values("01")),
              b::Element(e::Required,    "(RDFI) Identification Number"),
              b::Element(e::Required,    "Account Number Qualifier", b::Values("DA")),
              b::Element(e::Required,    "Account Number"),
              b::Element(e::Situational, "Date"),
              b::Element(e::NotUsed,     "Business Function Code"),
              b::Element(e::NotUsed,     "(DFI) ID Number Qualifier"),
              b::Element(e::NotUsed,     "(DFI) Identification Number"),
              b::Element(e::NotUsed,     "Account Number Qualifier"),
              b::Element(e::NotUsed,     "Account Number")),
            b::Segment(35, s::TRN, "Trace",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Trace Type Code", b::Values("1")),
              b::Element(e::Required,    "Reference Identification Number"),
              b::Element(e::NotUsed,     "Payer Identifier"),
              b::Element(e::NotUsed,     "Originating Company Supplemental Code")),

            d::LoopDef.build("N1", d::RepeatCount.bounded(1),
              b::Segment(65, s::N1, "Originator Name Identification",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Entity Identifier Code", b::Values("PR")),
                b::Element(e::Required,    "Name"),
                b::Element(e::Required,    "Identification Code Qualifier", b::Values("91")),
                b::Element(e::Required,    "Identification Code"),
                b::Element(e::NotUsed,     "Entity Relationship Code"),
                b::Element(e::NotUsed,     "Entity Identifier Code")),
              b::Segment(70, s::N1, "Receiver Name Identification",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Entity Identifier Code", b::Values("PE")),
                b::Element(e::Required,    "Name"),
                b::Element(e::NotUsed,     "Identification Code Qualifier"),
                b::Element(e::NotUsed,     "Payer Identifier"),
                b::Element(e::NotUsed,     "Entity Relationship Code"),
                b::Element(e::NotUsed,     "Entity Identifier Code")))),

          d::TableDef.detail("Table 2",
            d::LoopDef.build("ENT", d::RepeatCount.unbounded,
              b::Segment(100, s::ENT, "Entity",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Assigned Number")),

              d::LoopDef.build("RMR", d::RepeatCount.unbounded,
                b::Segment(150, s::RMR, "Remittance Advice Accounts Receivable Open Item Reference",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Reference Identification Qualifier", b::Values("CR")),
                  b::Element(e::Required,    "Reference Identification"),
                  b::Element(e::NotUsed,     "Payment Action Code"),
                  b::Element(e::Required,    "Monetary Amount"),
                  b::Element(e::Situational, "Monetary Amount"),
                  b::Element(e::Situational, "Monetary Amount")),
                b::Segment(170, s::REF, "Reference Identification",
                  r::Situational, d::RepeatCount.bounded(3),
                  b::Element(e::Required,    "Reference Identification Qualifier", b::Values("BAF", "3J", "OF")),
                  b::Element(e::Required,    "Reference Identfication"),
                  b::Element(e::Situational, "Description"),
                  b::Element(e::NotUsed,     ""))
              )
            )
          ),

          d::TableDef.detail("Table 3 - Summary",
            b::Segment(10, s::SE, "Transaction Set Trailer",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Transaction Segment Count"),
              b::Element(e::Required,    "Transaction Set Control Number"))))

      end
    end
  end
end
