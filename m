From: Niklas Werner <bergtroll@gmx.li>
Subject: USB-Audio (EMI 2|6)
Date: Tue, 4 Jun 2002 10:37:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206040837.KAA02647@papaschlumpf.wg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi All!

the silent reader strikes again...

Thanks a lot for usb-audio-support in alsa!

Just to let you know:
it works fine with the emagic emi2|6-interface by using the 
oss-firmware-loader from http://www.vtoy.fi/~tapio/emi26.html and 
rmmod-ing "audio" afterwards!

I tried it on a powerbook pismo (G3 500), but it should work on a pc as 
well. (since the FW-Loader works on both)

capture seems to work as well, at least the soundcard switched into 
record-mode...

Now this would allow me to use jack for my thesis instead of portaudio. 
Great! :-)

Have fun*

Niklas

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
