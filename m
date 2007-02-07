From: Shingo HORISAWA <tora2329@yahoo.co.jp>
Subject: Problems with Realtek HD Audio
Date: Wed, 7 Feb 2007 10:26:32 +0900 (JST)
Message-ID: <20070207012632.28910.qmail@web3211.mail.kcd.yahoo.co.jp>
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

Hi, alsa developers.

I have two problems about Realtek HD audio.

(1) Capturing stops suddenly

  When I was capturing a sound from microphone for
recording voice 
  using "arecord", it had stopped suddenly.
  After that, I couldn't capture a sound at all.
  To repair this situation, I had to restart ALSA or
system.
  
  It seems that this problem occurs when there are heavily
loads. 
  (For example, when I was using ethereal, it occured.) 


(2) Sound from embedded speaker

  When I plug a headphone into PC,
  I can hear sounds from both of headephone and embedded
speaker.
  (Normally, sounds should be heard from headphone.)
  
Are these known problem?
And if you know how to avoid them, please tell me.


FYI, my PC is TOSHIBA dynabook Satellite K10, 
and my distro is Fedora Core 6.
The audio device is ATI technologies SB450 HDA Audio.


Best regards.

--------------------------------------
Start Yahoo! Auction now! Check out the cool campaign
http://pr.mail.yahoo.co.jp/auction/


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
