From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: PCM Params
Date: Tue, 25 May 2004 11:50:28 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040525105028.39912.qmail@web25102.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi ,
i'm trying to change the fragment size that the alsa
driver is capturing/playing out. It's currently set at
32 msecs(256 bytes).
They are set in the runtime structure...
   runtime->period_max ...etc
Could anybody tell me which file these parameters are
set in the alsa-driver directory?
Thanks,
Brian.


	
	
		
____________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
