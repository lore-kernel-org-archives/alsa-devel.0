From: Anthony Truong <Anthony.Truong@mascorp.com>
Subject: Support for multiple codecs
Date: Thu, 29 May 2003 23:02:29 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054274549.10841.9.camel@huykhoi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,
I have a sound card (VIA 8235) with 4 codecs.  I already made all the
necessary driver changes to support them.  The issue is how I can allow
existing ALSA applications to take advantage of these extra codecs. How
can the applications be assigned a particular codec for recording or
playback, transparently, without modification to the ALSA lib, and
therefore the applications themselves?
Any suggestion, please?

Regards,
Anthony Dominic Truong. 





-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
