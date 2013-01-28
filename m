From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH - TINYCOMPRESS 4/4] compress: Do not put
 newlines on error messages
Date: Sun, 27 Jan 2013 22:13:57 -0800
Message-ID: <20130128061357.GN26562@intel.com>
References: <1359110594-20163-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1359110594-20163-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1359110594-20163-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, vinod.koul@linux.jf.intel.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 25, 2013 at 10:43:14AM +0000, Charles Keepax wrote:
> In the oops function text is appended onto the end of the supplied error
> message, so newlines appear in the middle of error messages. This patch
> removes all newlines from supplied error messages.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Applied all 4, thanks.

--
~Vinod
