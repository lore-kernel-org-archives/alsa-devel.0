From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: 2 Au1xxx (Alchemy) AC97 drivers
Date: Tue, 7 Oct 2008 15:36:45 +0200
Message-ID: <20081007133645.GA13668@roarinelk.homelinux.net>
References: <1223386106.31477.3.camel@kh-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1223386106.31477.3.camel@kh-ubuntu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-mips <linux-mips@linux-mips.org>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2008 at 08:28:26AM -0500, Kevin Hickey wrote:
> There appear to be 2 AC97 drivers for Alchemy in the latest Linux tree.
> One is in sound/mips and the other is in sound/soc.  Are both going to
> be maintained going forward?  If not, which one will be?  

The one in sound/soc is for Au1200/Au1550; I think the sound/mips one only
works on Au1000/Au1500.

	Manuel Lauss
