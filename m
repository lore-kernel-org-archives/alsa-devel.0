From: "David Shust" <dshust@bemail.org>
Subject: Patch: YMF753 AC '97
Date: Mon, 23 Sep 2002 21:28:09 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209240428.g8O4S9321071@mail12.bigmailbox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: binary
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've written a patches for the 0.9.0rc2 and 0.9.0rc3 ac97-codec driver in order to support the Yamaha YMF753. This chip is used in the Toshiba Satellite 5000. Support is provided for S/PDIF output, enhanced (wide) stereo, and the non-standard tone controls. All features appear to work.

Grab it here: www.shustring.net

I would be delighted to have this merged with the ALSA driver, provided that my copyright notice is left intact. It is only written to the console if and when the YMF753 is actually detected: ALSA AC'97 patch for Yamaha YMF753 (c) David Shust <dshust@shustring.com>

Is this an unreasonable request?

Regards,
David Shust


------------------------------------------------------------
Free, BeOS-friendly email accounts: http://BeMail.org/
BeOS News and Community: http://www.BeGroovy.com/


---------------------------------------------------------------------
Express yourself with a super cool email address from BigMailBox.com.
Hundreds of choices. It's free!
http://www.bigmailbox.com
---------------------------------------------------------------------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
