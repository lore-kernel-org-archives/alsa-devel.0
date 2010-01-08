From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ac97: merge WM9703 and WM9705 ops
Date: Fri, 8 Jan 2010 08:57:39 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001080857040.4210@eeebox2.perex-int.cz>
References: <20100101190543.b22c3861.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EB56F2463E
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 08:57:39 +0100 (CET)
In-Reply-To: <20100101190543.b22c3861.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 1 Jan 2010, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> The WM9705 and WM9703 ops are the same actually so use
> the same code for both.
>
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Thanks. I've applied your patch to my "devel" git branch.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
