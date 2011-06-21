From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Re: [PATCH] ASoC: codecs: Max98095: Fix logging of
	hardware	revision.
Date: Tue, 21 Jun 2011 13:48:02 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DDEC8CAD9@ITSVLEX06.it.maxim-ic.internal>
References: <1308596072-17158-1-git-send-email-thutt@chromium.org>
	<20110621002322.GE1905@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40DDEC16D42@ITSVLEX06.it.maxim-ic.internal>
	<20110621011038.GA4322@opensource.wolfsonmicro.com>
	<20110621115547.GD25032@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id AA12C24611
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 22:49:36 +0200 (CEST)
In-Reply-To: <20110621115547.GD25032@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Olof@alsa-project.org, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Taylor Hutt <thutt@chromium.org>, Johansson <olofj@chromium.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 21, 2011, Mark Brown wrote:
> On Tue, Jun 21, 2011 at 02:10:39AM +0100, Mark Brown wrote:
> > On Mon, Jun 20, 2011 at 05:43:58PM -0700, Peter Hsiang wrote:
> 
> > > I checked with hardware engineering and was told 0x40=RevA,
> 0x41=RevB..
> 
> This means if you're OK with it I can apply the patch as-is, BTW.

Acked-by: Peter Hsiang <peter.hsiang@maxim-ic.com>
