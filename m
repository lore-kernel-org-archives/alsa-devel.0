From: Jesse Chappell <jesse@essej.net>
Subject: Re: Problems with HDSP Multiface+CardBus
Date: Thu, 12 Jun 2003 11:14:10 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <f5fb8f1ddf2fd896fea87cf2331a64c2@essej.net>
References: <200306121542.41261.Jaakko.Prattala@Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306121542.41261.Jaakko.Prattala@Helsinki.FI>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?= <Jaakko.Prattala@Helsinki.FI>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaakko =?iso-8859-15?q?Pr=E4tt=E4l=E4?= wrote on Thu, 12-Jun-2003:

 > Encouraged by Jesse's recent success I tried again,
 > now with firmware rev 10. The module loads,
 > firmware is loaded but with
 > Hwdep ioctl error on card hw:0 : Input/output error.
 
If you're still getting the I/O error on the hdsploader then its
hard to know what state the thing is really in.

The current drivers only work for me if I boot to windows, (red
light goes out), reboot to linux (red light flashing until modules
load).  I see no errors of any kind if I do that.  Is this what you 
are doing?  I have rev 11, BTW.

jlc


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
