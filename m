From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA SOC in the ARM linux kernel - pxa2xx-pcm oops
	on invalid dma_ch.
Date: Mon, 20 Oct 2008 11:19:24 +0100
Message-ID: <20081020101924.GC18798@sirena.org.uk>
References: <48FC45E8.2060705@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 962231037F4
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 12:19:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48FC45E8.2060705@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2008 at 09:48:40AM +0100, Oliver Ford wrote:

> This mostly works but I'm having trouble with oopses due to invalid DMA 
> channels in pxa2xx-pcm.c. Is this the right place to ask about this, if 
> so I'll post the details here (which I already posted on the arm-linux 

Yes, this is the right place to post.

> mailing list). Is there a branch on wolfsonmicro.com that would be 
> closer to what is now in the main kernel?

No.
