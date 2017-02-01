From: Mylene Josserand <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH v3 1/8] ASoC: sun4i-i2s: Update binding
 documentation to include A31
Date: Wed, 1 Feb 2017 16:08:50 +0100
Message-ID: <b0611ab1-5b69-23da-6835-278d0fd1b6ba@free-electrons.com>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-2-mylene.josserand@free-electrons.com>
 <20170131211702.taxbrgxwo7b4daej@sirena.org.uk>
 <feb16b69-388f-10e5-7be5-c750095ee52b@free-electrons.com>
 <20170201115958.7a2odxxyhzm3ofew@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CCC6267480
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 16:09:31 +0100 (CET)
In-Reply-To: <20170201115958.7a2odxxyhzm3ofew@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, wens@csie.org, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 01/02/2017 12:59, Mark Brown wrote:
> On Wed, Feb 01, 2017 at 08:44:56AM +0100, Mylene Josserand wrote:
>> On 31/01/2017 22:17, Mark Brown wrote:
>>> On Tue, Jan 31, 2017 at 11:05:45AM +0100, Myl=E8ne Josserand wrote:
>>>> Add a new compatible for sun4i-i2s driver to handle some
>>>> SoCs that have a reset line that must be asserted/deasserted.
>
>>> This doesn't apply against current code, please check and resend.
>
>> I based my series on linux-next 20170131. Which one I should use?
>
> You should be submitting against my git tree (which should be what's in
> -next...).
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>

Okay, thank you! I will update my series according to your branch.

Best regards,

-- =

Myl=E8ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
