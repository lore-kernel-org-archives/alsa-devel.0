From: Jos Hulzink <josh@stack.nl>
Subject: Re: 2.5.5-pre1: Deadlocks and ALSA driver problems
Date: Fri, 15 Feb 2002 13:53:39 +0100
Message-ID: <20020215124929.XEKK19167.amsfep16-int.chello.nl@there>
References: <Pine.LNX.4.31.0202151311120.608-200000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from amsfep16-int.chello.nl (amsfep16-int.chello.nl [213.46.243.25])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA27951
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 13:53:52 +0100
In-Reply-To: <Pine.LNX.4.31.0202151311120.608-200000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 15 February 2002 13:12, Jaroslav Kysela wrote:
>
> Attached patch for linux/sound/core/info.c fixes the problem with /proc
> entries.
>

Confirmed.  /proc interface seems working as expected. 

Jos
 


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
