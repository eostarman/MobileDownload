// every downloaded record (see RecordSets) has a recNid, recKey and recName. Each record is downloaded as a \t delimited string (so, the field's
// position is very important - it can't be changed)
public protocol Record {
    var recNid: Int { get set }
    var recKey: String { get set }
    var recName: String { get set }

    init()
}
