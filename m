From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 01/11] wss_lib: move cs4231_lib into wss_lib
Date: Thu, 31 Jul 2008 21:06:50 +0200
Message-ID: <48920D4A.1000600@keyaccess.nl>
References: <20080731210017.445381d5.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id B2F042447B
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 21:04:13 +0200 (CEST)
In-Reply-To: <20080731210017.445381d5.krzysztof.h1@poczta.fm>
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
Cc: Takashi Iwai <tiwai@suse.de>, " @interia.pl" <alsa-devel@alsa-project.org>, Alsa-devel@interia.pl, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 31-07-08 21:00, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Move the file sound/isa/cs423x/cs4231_lib.c
> into sound/isa/cs423x/wss_lib.c
> This is the first step toward merging all libraries
> for Windows Sound System compatible chips
> into a single library.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Acked-by: Rene Herman <rene.herman@gmail.com>
> ---
> This is second revision of the patch set. It is redone versus linux-2.6.27-rc1-mm.
> 
> This patch has not been changed since previous posting.

Thanks for noting that. If you'd know how hot is was here, you'd forgive 
me for postponing looking until tomorrow.

Unlike the others upto now, you addressed this first message to 
"Alsa-devel@interia.pl" and "<alsa-devel@alsa-project.org>@interia.pl" 
and it has indeed not made it to the regular alsa-devel list.

Rene.
