From: John Covici <covici@ccs.covici.com>
Subject: shutting down alsa causes paging exception
Date: Wed, 27 Mar 2002 01:58:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m37knymr89.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I am using the alsa which is integrated into the 2.5.7 kernel and I am
getting unable to handle kernel paging whenever I try to shutdown the
alsa drivers.  I have it as modules and I think it can't delete the
module.  I can supply the log entries if that would help.

I am using the via8233 modules.

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
