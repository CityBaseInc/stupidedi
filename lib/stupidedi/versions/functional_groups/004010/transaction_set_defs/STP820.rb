module Stupidedi
  module Versions
    module FunctionalGroups
      module FortyTen
        module TransactionSetDefs

          d = Schema
          r = FortyTen::SegmentReqs
          s = FortyTen::SegmentDefs

          STP820 = d::TransactionSetDef.build("RA", "820",
            "Payment Order/Remittance Advice",

            d::TableDef.header("Table 1 - Header",
              s::ST .use(10, r::Mandatory, d::RepeatCount.bounded(1)),
              s::BPR.use(20, r::Mandatory, d::RepeatCount.bounded(1)),
              s::TRN.use(35, r::Mandatory, d::RepeatCount.bounded(1)),

              d::LoopDef.build("N1", d::RepeatCount.bounded(1),
                s::N1.use(65, r::Mandatory, d::RepeatCount.bounded(1)),
                s::N1.use(70, r::Mandatory, d::RepeatCount.bounded(1)))),

            d::TableDef.detail("Table 2 - Detail",
              d::LoopDef.build("ENT", d::RepeatCount.unbounded,
                s::ENT.use(10, r::Mandatory, d::RepeatCount.bounded(1)),

                d::LoopDef.build("RMR", d::RepeatCount.unbounded,
                  s::RMR.use(150, r::Mandatory, d::RepeatCount.bounded(1)),
                  s::REF.use(170, r::Optional,  d::RepeatCount.bounded(1)),
                  s::DTM.use(180, r::Optional,  d::RepeatCount.bounded(1)),
                )
              )
            )
          )
        end
      end
    end
  end
end
