From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Blackfin ASoC drivers with multi-component
Date: Mon, 29 Nov 2010 10:56:02 +0000
Message-ID: <20101129105602.GN30360@rakim.wolfsonmicro.main>
References: <20101128123558.GB12683@opensource.wolfsonmicro.com>
	<DB904C5425BA6F4E8424B3B51A1414D1659B574C63@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29F1C2451F
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 11:56:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D1659B574C63@NWD2CMBX1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Cc: "Cai, Cliff" <Cliff.Cai@analog.com>, Mike Frysinger <vapier@gentoo.org>, Barry Song <21cnbao@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 28, 2010 at 09:27:17PM -0500, Zhang, Sonic wrote:

[Reflowed into 80 columns]

> We are busy with 2010R1 Linux on blackfin release based on kernel
> 2.6.34. There is no activity in ADI on multi component audio drivers in
> latest 2.6.37 rc kernel. However, we are switching to the 2011
> development cycle soon, which will cover some audio drivers on top of
> the multi-component framework.

Please bear in mind that 2.6.37 will be released probably around the end
of next month so it's important to get testing and any fixes done before
then.
