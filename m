From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 3/6] ASoC: Add SOC_DOUBLE_R_SX_TLV control
Date: Sun, 16 May 2010 18:09:52 +0100
Message-ID: <20100516170853.GA9830@opensource.wolfsonmicro.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153130.338630785@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100515153130.338630785@mandriva.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, May 15, 2010 at 05:30:01PM +0200, apatard@mandriva.com wrote:
> This patch is adding a new control which has the following capabilities:
> - tlv
> - variable data size (for instance, 7 ou 8 bit)
> - double mixer
> - data range centered around 0
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

I've applied this one.  Please remember to CC both myself and Liam on
ASoc patches.
