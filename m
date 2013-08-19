From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/1] alsa-lib: update hdspm.h
Date: Mon, 19 Aug 2013 17:31:36 +0200
Message-ID: <1376926297-6028-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Here's the patch for alsa-lib to fix the broken LTC ioctl.


Cheers

Adrian Knoth (1):
  hdspm.h: Update LTC ioctl to use struct hdspm_ltc

 include/sound/hdspm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3.2
