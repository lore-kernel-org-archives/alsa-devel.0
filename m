From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Mixer Problem
Date: Tue, 19 Feb 2002 14:20:14 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202191419440.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA26791
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 14:21:17 +0100
In-Reply-To: <XFMail.20020219141437.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Feb 2002, Guenther Sohler wrote:

> I do not hear midi reverb. could it be, that it does not work because of
> incorrect signal routing in my audixy ?

We have no DSP code for reverb and chorus effects.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
