From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Subject: [PATCH v2 0/5] Add Phytec pbab01 audio support
Date: Fri, 12 Sep 2014 19:04:28 +0300
Message-ID: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s250.sam-solutions.net (s250.sam-solutions.net [217.21.49.219])
 by alsa0.perex.cz (Postfix) with ESMTP id 09967261AB7
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 18:04:48 +0200 (CEST)
In-Reply-To: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shawn.guo@freescale.com, kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de
Cc: =devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Since previous patchset version asoc machine driver imx-tlv320aic3x
was replaced with simple-audio-card and audmux.
Also changed commit message for first patch, which now explicitly
states that it has more than stylistic purpose.
