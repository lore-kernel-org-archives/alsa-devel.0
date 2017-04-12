From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2] ASoC: fsl ssi doc: Move optional
 properties to the correct section
Date: Wed, 12 Apr 2017 08:33:02 -0500
Message-ID: <6cfdadb9-8cd3-2717-1017-b78608f32224@tabi.org>
References: <1492003920-30038-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id E6132266F89
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 15:33:04 +0200 (CEST)
In-Reply-To: <1492003920-30038-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, broonie@kernel.org
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> Properties 'fsl,ssi-asynchronous', 'fsl,playback-dma' and 'fsl,capture-dma'
> are optional, so move them under the optional section of the document.
>
> While at it mention that 'fsl,playback-dma' and 'fsl,capture-dma'
> only apply to Power Architecture.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

ACK
