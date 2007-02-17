From: Jean-Michel =?ISO-8859-1?Q?Pour=E9?= <jmpoure@free.fr>
Subject: Persistant naming of Terratec Aureon 5.1 USB MK.2
Date: Sat, 17 Feb 2007 14:36:47 +0100
Message-ID: <1171719407.5843.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Dear friends,

I have a Terratec Aureon 5.1 USB MK.2 device.

Presently, Alsa displays:

cat /proc/asound/cards
 0 [UA25           ]: USB-Audio - EDIROL UA-25
                      Roland EDIROL UA-25 at usb-0000:00:0b.0-2, full
speed
 1 [Audio          ]: USB-Audio - USB Audio
                      USB Audio at usb-0000:00:0b.1-4.4.3, full speed

The name for the "Aureon 5.1 USB MK.2" is simply "Audio".
Is there a solution to name it Aureon 5.1 USB MK.2?

P.S. The wiki page for this device is here:
http://alsa.opensrc.org/Terratec_Aureon_5.1_USB_MK.2

Kind regards,
Jean-Michel
 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
