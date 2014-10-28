From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 00/11] Add AXD Audio Processing IP driver
Date: Tue, 28 Oct 2014 13:06:25 +0100
Message-ID: <544F86C1.8040500@metafoo.de>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/28/2014 12:26 PM, Qais Yousef wrote:
> AXD Audio Processing IP performs audio decoding, encoding, mixing, equalisation,
> synchronisation and playback. This series adds the driver and DT binding
> document.
> [...]
> I added it to drivers/char as this is the best location I could think of at the
> moment. It doesn't fit in alsa subsystem but I Cced them to confirm.
 > [...]

I think it will fit in nicely.

- Lars
