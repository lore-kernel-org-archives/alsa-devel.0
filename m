From: Liam Girdwood <lrg@kernel.org>
Subject: Re: Where can I find some info about the DAI?
Date: Mon, 08 Sep 2008 10:07:10 +0100
Message-ID: <1220864830.17091.77.camel@odin>
References: <48C4EA43.2090607@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id DAB542452A
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 11:07:14 +0200 (CEST)
In-Reply-To: <48C4EA43.2090607@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-09-08 at 11:02 +0200, Sedji Gaouaou wrote:
> Hi,
> 
> I am trying to write a DAI.
> I am working with a wolfson wm8731 and an atmel at91sam9g20. Basically I 
> had a look at the file eti_b1_wm8731.c, but I would like to use another 
> ssc archi(atmel_ssc instead of at91_ssc).
> So I would like to know where should I find some info concerning the DAI.
> 

Have you looked in Documentation/sound/alsa/soc ?

Liam
