From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: submitting a patch against the ALSA repos
Date: Fri, 18 May 2007 12:02:14 +0100
Message-ID: <1179486134.12561.59.camel@localhost.localdomain>
References: <92a12cdb0705180216k4bb70a64x7da9c03313220623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 781A82415F
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 13:02:16 +0200 (CEST)
In-Reply-To: <92a12cdb0705180216k4bb70a64x7da9c03313220623@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-05-18 at 10:16 +0100, Adrian McMenamin wrote:

> 3. This is a new architecture - there are no other SuperH drivers in
> alsa (afaik) - how do I add a new architecture? My memory is that when
> I tried this a year ago it was a bit of a nightmare.

Fwiw, there is a now a SuperH ASoC DMA, I2S and AC97 driver in
sound/soc/sh (in alsa-kernel Hg). Very recently added. 

Liam
