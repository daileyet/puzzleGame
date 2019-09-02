#ifndef DEFINE_H
#define DEFINE_H
#ifndef DECLARE_PROPERTY
#define DECLARE_PROPERTY(type, name, Name) \
    Q_PROPERTY(type name READ name WRITE set##Name NOTIFY name##Changed) \
    public: \
    Q_INVOKABLE type name() const {return m_##name;} \
    Q_INVOKABLE void set##Name(type name) {if(m_##name == name) return; m_##name = name; emit name##Changed();} \
    private: \
    type m_##name;
#endif
#endif // DEFINE_H
