From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Fix ESAI_xCCR_xDC_WIDTH
	definition
Date: Thu, 18 Dec 2014 14:41:55 -0200
Message-ID: <CAOMZO5A5qbtXfdQOAs08m1MUp0inT5eyYyRrD1ZKbb8DpMj_og@mail.gmail.com>
References: <302670613.333771.1418920671738.JavaMail.yahoo@jws11119.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <302670613.333771.1418920671738.JavaMail.yahoo@jws11119.mail.ir2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aurelien Bouin <a_bouin@yahoo.fr>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 18, 2014 at 2:37 PM, Aurelien Bouin <a_bouin@yahoo.fr> wrote:
> From 9bcae891b8fe7a42cbc2cd88319f7bd4ab44d012 Mon Sep 17 00:00:00 2001
> From: Aurelien BOUIN <a_bouin@yahoo.fr>
> Date: Thu, 18 Dec 2014 15:14:53 +0100
> Subject: [PATCH 1/1] According to the mx6 reference manual the TDC and RDC
> field of registers ESAI_TCCR and ESAI_RCCR have a width of 5 bits, not 4

You are not using git send-email, are you?

The commit log appears now incorrectly in the subject.
