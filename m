From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Module names for these cards
Date: Sun, 4 Aug 2002 21:59:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208042155380.951-100000@pnote.perex-int.cz>
References: <3D4AED62.6040102@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA13187
	for <alsa-devel@alsa-project.org>; Sun, 4 Aug 2002 21:59:36 +0200
In-Reply-To: <3D4AED62.6040102@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 3 Aug 2002, Patrick Shirkey wrote:

> Can anyone tell me the module name for these cards?
> 
> alesis adat/pcr

Unsupported.

> Analog Devices AD1845

Unsupported.

> Oak technology Mozart

snd-opti92x-ad1848.o

> Philips  UDA1341TS  h3600-uda1341 iPAQ H3X00 hardware

snd-sa11xx-uda1341.o

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
