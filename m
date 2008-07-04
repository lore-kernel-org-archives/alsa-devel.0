From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Using BD in place of DMA in soc driver
Date: Fri, 04 Jul 2008 13:41:29 +0100
Message-ID: <1215175289.4882.128.camel@localhost.localdomain>
References: <1215173518.16282.19.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D482B24A5D
	for <Alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 14:41:30 +0200 (CEST)
In-Reply-To: <1215173518.16282.19.camel@dinesh.dua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dinesh <dinesh.dua@coraltele.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-07-04 at 17:41 +0530, dinesh wrote:
> Hi i want to use mpc8323 ucc tdm as sound soc device but i dont know how
> to configure its buffer descriptor because every soc device available
> uses DMA. Please help. 
> 

Do you mean Programmed IO ?

Liam
