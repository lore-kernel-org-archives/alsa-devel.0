From: Daniel Drake <drake@endlessm.com>
Subject: Realtek HDA SKU/assembly parsing
Date: Tue, 11 Nov 2014 07:11:42 -0600
Message-ID: <CAD8Lp456gAr43A6Q7AOVmc3RLXPEqLpFcgfogQR9DiBz1gjB2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

Hi,

I see that there is a function that parses the subsystem ID for
various realtek codecs, alc_auto_parse_customize_define

Is there a public specification that documents the specific meaning of
each bit here?

Thanks
Daniel
