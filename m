From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsactl has no 'names' command anymore
Date: Thu, 28 Apr 2011 08:14:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1104280814150.12295@eeebox2.perex-int.cz>
References: <201104271222.57027.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B2F0103951
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 08:14:27 +0200 (CEST)
In-Reply-To: <201104271222.57027.alexander.stein@systec-electronic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Apr 2011, Alexander Stein wrote:

> Hello,
>
> alsactl doesn't have a names comamnd anymore. It was removed with commit
> ef8bfcecda9b500f6e71465a396cc5e01a2671bf but the help text still exists.
> Please consider reverting commit 6d32e055d73edfe6be90135c500dcb32491cf04d.
> Thanks

Done. Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
