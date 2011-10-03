From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
Date: Mon, 3 Oct 2011 13:07:41 +0100
Message-ID: <20111003120741.GD23811@sirena.org.uk>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<3289863.m6ULFZUV3p@wuerfel> <004e01cc8198$848347f0$8d89d7d0$@com>
	<1869072.QQLATNzYYx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1869072.QQLATNzYYx@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, 'Jassi Brar' <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, 'Liam Girdwood' <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 01:50:08PM +0200, Arnd Bergmann wrote:

> the patch. The other problem in this patch is still there, with
> CONFIG_SND_SOC_SMDK_WM8994_PCM=y and CONFIG_MFD_WM8994=n:

You've not sent a seprate patch for that one yet...
