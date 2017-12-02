From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 9/9] ASoC: eukrea-tlv320: Remove include line of fsl_ssi.h
Date: Fri, 1 Dec 2017 22:34:55 -0800
Message-ID: <20171202063454.GA9256@Asurada-CZ80>
References: <1512195805-9023-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512195805-9023-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 01, 2017 at 10:23:25PM -0800, Nicolin Chen wrote:
> The eukrea-tlv320 driver is still compiled successfully without
> any erorr using imx_v6_v6_defconfig, after removing it.

A typo here, should be imx_v6_v7_defconfig. Sending a v2 anyway.

Please ignore this version. Thanks.
