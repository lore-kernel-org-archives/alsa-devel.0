From: Martin.Soto@t-online.de (Martin Soto)
Subject: Emu10k1 programming with ALSA
Date: 11 Oct 2002 23:13:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034370785.1657.12.camel@masoft>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-spZ7p95bVyXcyY7h4G8S"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-spZ7p95bVyXcyY7h4G8S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all!

As promissed, here goes a quick and dirty example showing how to program
the emu10k1 chip (found in the popular Sound Blaster Live! card) with
the ALSA drivers.  The example requires ALSA CVS from today and the
alsalib source code in order to compile and run.

The DSP program already harcoded there is trivial, but you can modify it
to something more interesting.  I'm starting work on a Python based
patch manager for ALSA, but that will still take some time.

Enjoy,

M. S.

P. S. Please replay directly to this address if you want to reach me
during the weekend.  Currently I don't have access to my usual e-mail
account.

--=-spZ7p95bVyXcyY7h4G8S
Content-Disposition: attachment; filename=emu10k1-program.tar.gz
Content-Type: application/x-gzip; name=emu10k1-program.tar.gz
Content-Transfer-Encoding: base64

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
FVTwZ4P/AiQKHvkAUAAA

--=-spZ7p95bVyXcyY7h4G8S--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
