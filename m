From: Tobin Davis <tdavis@dsl-only.net>
Subject: Creative Labs XFi drivers.
Date: Wed, 26 Sep 2007 22:29:57 -0700
Message-ID: <1190870997.30667.140.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id D15951037F0
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Sep 2007 07:29:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Creative Labs has released a proprietary driver base for their XFi
cards.  I downloaded it because it claims to have compatibility with
alsa.  In fact, it requires alsa include files to be able to compile.  I
haven't looked at the source yet (this information is all in the
Readme.txt in the  main download) and probably won't (especially since I
don't own a Creative Labs XFi card).

What I don't understand, is are they allowed to use our code to build
their drivers?  They use alsa core modules to interoperate (from what I
can tell in the Readme.txt).  Also, this line in the License.txt is
especially troubling:



> In the event that the Software includes Linux code or drivers, then, unless expressly stated to the contrary, such Linux
> code and drivers are proprietary to Creative and all rights therein are reserved.



I'm deleting all but the big tarball I downloaded.  I'll delete it
later.

-- 
Tobin Davis <tdavis@dsl-only.net>
