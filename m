From: John Covici <covici@ccs.covici.com>
Subject: 2.5.6 wrong interrupt acknowledged with alsa
Date: Tue, 19 Mar 2002 01:14:00 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3sn6xf5jr.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

HI.  Using kernel 2.5.6 and the included alsa drivers and the beta 12
libraries and utilities I get lots of messages like the following:
Mar 18 20:23:32 ccs kernel: ALSA pcm_lib.c:184: Unexpected hw_pointer
value (stream = 1, delta: -2048, max jitter = 16384): wrong i\nterrupt
acknowledge?

This is with the via8233 sound card.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
