From: Olivier Ricordeau <olivier.ricordeau@wanadoo.fr>
Subject: Re: [BUG] buggy ali5451 driver
Date: Mon, 04 Nov 2002 16:20:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC6903B.1070309@wanadoo.fr>
References: <m24raxpndj.fsf@vador.mandrakesoft.com> <s5hu1ixa0eu.wl@alsa2.suse.de> <3DC68350.2040208@wanadoo.fr> <3DC68814.6070700@wanadoo.fr> <20021104112035.GA14883@dogsolitude.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

drclaw@dogsolitude.org wrote:
> Try disabling "use dma by default" in the ide section.  If that then
> fixes the problem I have a patch that can get you dma back.  I've got an
> ali southbridge in my laptop as well and everything works fine.  
> 
> 784 - Michael C. Piantedosi - drclaw@dogsolitude.org

OK...
How can I disable dma in a shell??? Or do I need to recompile the kernel 
or something?

-- 

  -= *Olivier RICORDEAU* =-   |  ICQ: 65452304
  Ing1 EPITA Millesime 2005   | Phone: 0686720852
           olivier.ricordeau@wanadoo.fr
          _Might the source be with you_



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
