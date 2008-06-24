From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RESEND][PATCH 1/2] wss_lib: move cs4231_lib into
	wss_lib
Date: Tue, 24 Jun 2008 22:09:19 +0200
Message-ID: <4861546F.7010202@keyaccess.nl>
References: <20080624185056.aa520cd3.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D39624A54
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jun 2008 22:08:40 +0200 (CEST)
In-Reply-To: <20080624185056.aa520cd3.krzysztof.h1@poczta.fm>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 24-06-08 18:50, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Move the file sound/isa/cs423x/cs4231_lib.c 
> into sound/isa/cs423x/wss_lib.c
> This is the first step toward merging all libraries
> for Windows Sound System compatible chips
> into a single library.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> 
> This is second version of the patch with makefile copyright
> changed to Jaroslav Kysela.
> Only the first patch from two is resend (the other one was already ok).

Thank you. As said, it felt a bit out of place and the problem may have 
been in my fantasy alone, but appreciated.

Acked-by: Rene Herman <rene.herman@gmail.com>

Rene.
