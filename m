From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] Asoc: samsung: clean makefile about inexistant files
Date: Mon, 29 Jan 2018 13:31:09 +0100
Message-ID: <CAJKOXPckV+UCUdFmgYx-6XPR_GwruOnOY-VE2qog6dNJAG5AOQ@mail.gmail.com>
References: <1517228776-1617-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517228776-1617-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Corentin Labbe <clabbe@baylibre.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, Sylwester Nawrocki <s.nawrocki@samsung.com>, sbkim73@samsung.com, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 29, 2018 at 1:26 PM, Corentin Labbe <clabbe@baylibre.com> wrote:
> Clean makefile rules about inexistant files.
> Thoses files were removed in commit a076d418235f ("ASoC: samsung: Drop AC97 drivers")
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  sound/soc/samsung/Makefile | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
