From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: atmel-ssc: use devm_xxx() managed function
Date: Tue, 16 Oct 2012 14:12:24 +0900
Message-ID: <20121016051221.GA8670@opensource.wolfsonmicro.com>
References: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 16, 2012 at 11:56:58AM +0800, Bo Shen wrote:
> Using the devm_xxx() managed function to stripdown the error
> and remove code.

Applied both, thanks.
