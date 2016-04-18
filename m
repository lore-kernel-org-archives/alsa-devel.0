From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/7] ASoC: davinci-mcbsp: add binding
 for McBSP
Date: Mon, 18 Apr 2016 16:06:29 +0300
Message-ID: <5714DBD5.7060706@ti.com>
References: <1460982766-18632-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FFBA26154C
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 15:06:36 +0200 (CEST)
In-Reply-To: <1460982766-18632-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 04/18/16 15:32, Petr Kulhavy wrote:
> This series of patches adds devicetree support for the davinci McBSP audio
> interface.
> =

> Changes in version 3 of the patch:
> =

> * remove the index note from the "mpu" property in the binding
> * describe exactly the supported platforms in compatible string
> * remove unused platform data from davinci-i2s driver and the related EVK=
 board drivers

To all patches:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

-- =

P=E9ter
