From: John Covici <covici@ccs.covici.com>
Subject: removing sndtimer causes unable to handle kernel paging ...
Date: Thu, 25 Apr 2002 13:03:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3elh3ogm5.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi.  I was trying to usekernel 2.5.x (7-9) and alsa either the one in
the kernel tree or beta12, and whenever snd-timer module is to be
removed, I get unable to handle kernel paging exception ... and the
system crashes.

I am using a via8233 sound card.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
