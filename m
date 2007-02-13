From: "Ronald Stewart" <ronaldjstewart@gmail.com>
Subject: Hey guys really need help from Ron at Trinity Audio
Date: Tue, 13 Feb 2007 11:41:09 -0800
Message-ID: <4c84399f0702131141k3bd833cam5d450cb404c4ab3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Guys I am online and emailing you from Trinity the actual unit.
SORRY if I piss anyone off for doing this but I really need to get
past this critical empasse...below is an email that i wrote to
Giuliano, so everything is correct except I dont know if the driver is
loaded properly because I load up Audacity and echomixer and no audio
data is coming through on our scope.
Trinity is on the bench and working so could someone focus on getting
me past this hiccup?
thanking you in advance

Ronald Stewart
Trinity Audio Group

Giuliano,

Hi this is the first time I have ever taken a debugged trinity board and loaded
linux kernel build.  This build is the proof of concept build from the
development bread board which uses the echo indigo driver on the bread
board via PCMCIA BUS.

However the version that I am running is the same driver you wrote to
talk to the DSP chip and the Cirrus CODEC BUT through the PCI BUS.

Everything on the board is mechanically working EXCEPT I have no way
to know if the driver is loaded properly???

What we do know is that the PCMCIA BUS was not active because we have
NO PCMCIA chip.

We know for absolute FACT that we can see the card becasue we can see
the return on the PCI BUS.

Can you please login to my board and tell us if the driver is operational?

here is the IP 10.0.0.51
DNS 206.13.28.12
Gateway 10.0.0.1
Router 71.129.45.33
Gateway 71.129.45.33

ALSO here is another way to login if you have problems

Here's how to always access this machine:

 ssh trinityaudio.dyndns.org -l mika
 password: 123456

thank you and we are online and on standby

Please help

Ron

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
