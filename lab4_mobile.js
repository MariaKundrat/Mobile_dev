const mqtt = require('mqtt');
const broker = 'mqtt://test.mosquitto.org';
const port = 1883;
const dataTopic = 'sensor/temperature';
const reqTopic = 'sensor/temperature/request';

const client = mqtt.connect(broker, { port: port });

client.on('connect', () => {
    console.log('Connected to MQTT Broker');
    client.subscribe(reqTopic);
    setInterval(publishTemperature, 5000);
});

client.on('message', (topic, message) => {
    console.log(`Message on ${topic}: ${message.toString()}`);
    if (topic === reqTopic) {
        publishTemperature();
    }
});

function publishTemperature() {
    const temperature = (Math.random() * (38.0 - 36.0) + 36.0).toFixed(2);
    console.log(`Publishing temperature: ${temperature}`);
    client.publish(dataTopic, temperature);
}
